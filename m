Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbTAUSZM>; Tue, 21 Jan 2003 13:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267150AbTAUSZM>; Tue, 21 Jan 2003 13:25:12 -0500
Received: from mail.webmaster.com ([216.152.64.131]:6798 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267148AbTAUSZK> convert rfc822-to-8bit; Tue, 21 Jan 2003 13:25:10 -0500
From: David Schwartz <davids@webmaster.com>
To: <dana.lacoste@peregrine.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Tue, 21 Jan 2003 10:34:12 -0800
In-Reply-To: <1043165072.1397.61.camel@dlacoste.ottawa.loran.com>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20030121183414.AAA4503@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jan 2003 11:04:31 -0500, Dana Lacoste wrote:

>This means that the source code to the product you have must be
>in a form that is modifiable, and it must be in the 'preferred'
>form for YOU to modify that code.

>This has NOTHING to do with patches and tracking changes and
>communicating with Linus.  This has to do with the code to the
>software you use and YOUR ability to change it.

	This can't be right for two reasons.

	First, I would in fact prefer to have the version control 
information to make changes. The commit comments, for example, may 
explain the rationale for changes. Seeing who made a change may 
affect my level of confidence in that change. Also, seeing which 
changes were made a unit helps you to know what code affects what 
other code. Anyone who has ever modified a project that is managed 
through a version management system will tell you that they prefer to 
have access to the repository and the metainformation in it than just 
have the raw source code out of the repository.

	Second, what you say above would imply that if I prefer my source 
code on 30mm tape in EBCDIC format, then RedHat has to provide it to 
me since that's my preferred form.

	My best attempt at understanding what "preferred form for making 
changes" is the form that the people making the changes actually do 
in fact prefer.

	What happens when one party gets source code from another and both 
parties make changes. Suppose, hypothetically, Linus only gave out 
obfuscated source code. He can do that, since he doesn't distribute 
binaries. Now, can RedHat ship binaries of Linus' obfuscated source 
code? If so, anyone can evade the intent of the GPL just by creating 
a separate company. So it *can't* mean the preferred form of the 
person you got the binary from.

	I think it has to mean the preferred form for making changes by the 
people who actually do make changes. And I don't think you can 
justify removing any information that helps the people who make 
changes do their change-making, as that is not what they prefer.

	I think I've said all I have to say on this subject, especially 
since it doesn't affect the Linux kernel at this time. However, I 
caution against ever allowing a situation where the preferred form 
for making changes of any GPL'd project, preferred by the people 
making the changes, is in any way a proprietary system.

	DS


