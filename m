Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbTATVSV>; Mon, 20 Jan 2003 16:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbTATVSV>; Mon, 20 Jan 2003 16:18:21 -0500
Received: from mail.webmaster.com ([216.152.64.131]:28811 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266924AbTATVST> convert rfc822-to-8bit; Mon, 20 Jan 2003 16:18:19 -0500
From: David Schwartz <davids@webmaster.com>
To: <Valdis.Kletnieks@vt.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 20 Jan 2003 13:27:21 -0800
In-Reply-To: <200301202032.h0KKWrIJ023544@turing-police.cc.vt.edu>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030120212723.AAA1911@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 15:32:53 -0500, Valdis.Kletnieks@vt.edu wrote:
>On Mon, 20 Jan 2003 11:43:48 PST, David Schwartz said:

>>Checking source code out of a repository is an obfuscatory act
>>that
>>separates the raw source code from the rationale for that source
>>code. It's equivalent to stripping comments. The GPL does not allow

>So is shipping the source without the transcript of the kernel
>developer's
>conference, because then you're stripping out some of the design
>rationale.

	If a transcipt of the developer's conference is part of the 
preferred form of the source for making modifications, then the 
GPL requires that you distribute that. I would argue that it probably
isn't, but if many of the developers have access to that transcript 
it and use it while they make modifications, then it's an arguable 
point.

>So is shipping the source without a neuron dump of the programmer -
>let's face
>it, we've ALL looked at code and said "What WERE they thinking?",
>and therefor
>a neuron dump would be part of the *preferred* format.

	If the people who make most of the modifications have access to and 
use such a dump in the process of making modifications, then it would
probably be part of the preferred form.

>You seem determined to obfuscate the issue by confusing the *SOURCE*
>that
>actually gets modified, and metainformation used to keep TRACK of
>the source.

	You seem determined to pretend that by "source" the GPL means 
"whatever you can compile to create the executable" when it clearly 
says otehrwise.

>Don't confuse the source tree with metainformation, or you'll end up
>having
>to carry around inode information.  Lest you think I'm joking,
>consider the
>fact that the original Crowther&Woods Adventure game was called
>'ADVENT.FOR',
>and the case and number of chars was actually significant
>information....

	The test seems to be whether the metainformation is actually useful 
in the process of making modifications or, to put it another way, 
whether the people making such modifications prefer to have that 
information. I would certainly prefer to have change history and 
commit rationales. If the people who actually make most of the 
modifications actually have access to and use that information in the
process of making modifications, I don't see how you can argue that 
this information isn't part of the source as defined by the GPL.

	Keeping the comments in a different file and claiming that's not 
part of the source is completely equivalent to stripping the comments 
from the source before you distribute it. The GPL doesn't permit 
obfuscated source. "Just enough to compile it" isn't sufficient. It 
requires the "preferred form" for making modifications. If this 
actually includes design rationale documents, revision history, and 
other such things, then they are part of the source.

	The intent of the GPL seems to be to put "outside" developers on the 
same footing as "inside" developers. Being able to withhold 
development information that is actually useful for making 
modifications seems to be prohibited.

	This leaves interesting questions like how you can GPL a project 
that includes signed components.

	DS


