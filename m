Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbTATUKG>; Mon, 20 Jan 2003 15:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266849AbTATUKG>; Mon, 20 Jan 2003 15:10:06 -0500
Received: from mail.webmaster.com ([216.152.64.131]:8578 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266844AbTATUKB> convert rfc822-to-8bit; Mon, 20 Jan 2003 15:10:01 -0500
From: David Schwartz <davids@webmaster.com>
To: <david.lang@digitalinsight.com>
CC: <dana.lacoste@peregrine.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 20 Jan 2003 12:19:02 -0800
In-Reply-To: <Pine.LNX.4.44.0301201129510.6894-100000@dlang.diginsite.com>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030120201904.AAA25148@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 11:31:53 -0800 (PST), David Lang wrote:

>so are you saying it's illegal for an opensource project to use a
>commercial version control system, or that use of such a version
>control
>system by a GPL project forces the company to GPL their version
>control system?

	I don't understand how I can be clearer than I've already been. The 
GPL requires you to do some things if you want to distribute 
binaries. One of those things is to distribute the source code in the 
"preferred form" for modifying it. Thus, if you don't have the source 
code in its preferred form for making modifications, you can't 
distribute binaries.

	This then brings up two more complicated issues.

	First, what is the preferred form of a work for making modifications 
to it? Here, I argue that if a project is based around a version 
control system, then checking out the source code removes vital 
metainformation and does not produce the preferred form. The loss of 
the check in explanations and change history makes modifications more 
difficult.

	Second, is distributing useless source is equivalent to distributing 
no source at all? Here, I argue that distributing the source in the 
preferred form for making modifications to it but such that it cannot 
be actually modified without agreeing to a license other than the 
GPL, does not meet the GPL's requirements for source distribution.

	That's what I'm saying. You can draw whatever conclusions based upon 
my arguments that you like. But those are the two arguments I'm 
making and I've already posted the justifications for them.

	My motive in making these arguments is quite simple. If Congress had 
to comply with all of its laws, it'd probably make better laws. So if 
the people who choose to apply the GPL to their projects are more 
inconveniences by its quirky bits, perhaps they'll choose better 
licenses in the future.

	I submit that it is impossible to comply with the GPL and distribute 
binaries if the preferred form of a work for the purposes of making 
modifications to it is in a proprietary file format. This is 
tantamount to encrypting the source.

	DS


