Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUDPOig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUDPOig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:38:36 -0400
Received: from fork4.mail.Virginia.EDU ([128.143.2.194]:17876 "EHLO
	cms.mail.virginia.edu") by vger.kernel.org with ESMTP
	id S263205AbUDPOie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:38:34 -0400
Message-ID: <407FEFCA.5070602@virginia.edu>
Date: Fri, 16 Apr 2004 10:38:02 -0400
From: Aaron Smith <aws4y@virginia.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ANNOUNCE: AISF and ASTRIX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
    For the past few months the Virginia Astronomical Instrumentation
Laboratory has been working on a piece of software to control its
observing systems. These systems are built on the GNU/Linux Operating
System. The system we have designed is a new form of modular instrument
control. In the spirit of the GNU/Linux operating system we are making
this framework open source. 
    The framework called the Astronomical Instrumentation Software
Framework, or AISF. The goal of the framework is to provide simple
functions for observing tasks, such as exposing a CCD frame or writing a
FITS image to the disk. These tasks are handled with one or two uniform
function calls for all instruments. This makes it easy for even novice
programmers to automate data acquisition tasks. 
    The ASTRIX program is built on top of this framework and is designed
to take full advantage of this system. With the creation an environment
that competes with most commercial software packages like MaximDL/CCD or
CCDsoft, ASTRIX will hopefully give the community the opportunity to
build a tailored easy to use graphical image acquisition system that
utilizes all modern commercial CCD cameras. 
    Though the development of this software is in its early stages we
believe that the software and the framework it uses could allow the
observer much more flexibility. We encourage the community to help in
development by giving us feedback on the functions you would like
software like this to perform and your feedback on how it looks and or
functions. For those of you with programming experience we would like
for you to help by contributing some of your time and energy in
improving the software, by submitting patches and taking care bug
reports and documentation issues. 

Thank you for reading this email, the project website is: 
http://aisf.sourceforge.net 
Please feel free to email me at aws4y@astsun.astro.virginia.edu if you
have any questions about the project or how you may get involved. 

-Aaron Smith

PS I understand this is slightly OT but this project has a lot to do 
with interfacing kernel modules with userland applications.
