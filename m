Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbTAIBo3>; Wed, 8 Jan 2003 20:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTAIBnf>; Wed, 8 Jan 2003 20:43:35 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:18807 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261310AbTAIBn1>; Wed, 8 Jan 2003 20:43:27 -0500
Message-Id: <5.2.0.9.0.20030108181618.00b28100@pop.sbcglobal.yahoo.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 08 Jan 2003 19:52:03 -0600
To: rms@gnu.org
From: Billy Rose <passive_induction@sbcglobal.net>
Subject: free software
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after growing tired of trying to sift through the emails for tidbits of 
useful code, i have come to the conclusion that this thread should be 
geared towards something more constructive, otherwise i fear people will 
begin to find `open source' and `free software' distasteful.

in an ideal world (star trek comes to mind), everything would be free, not 
just software. everything has stemmed in some way from an idea, or group of 
ideas, even if it is a piece of furniture. money would not exist in such a 
free world, and people would work for incentives based upon the type of job 
they perform (i.e. a trash collector is only required to work one day a 
month while a corporate ceo which must work 7 days a week) and/or their 
abilities. such a system would be formed from a 100% pure democracy with 0% 
capitalism. if you choose not to work (the choice is yours), you starve and 
die on the street, simple as that. but the choice is yours. freedom is 
about personal choices that do not impact others in a negative way which 
removes their freedom. open source software (democratic software + possible 
capitalistic gains), such as the linux kernel, is the first step needed 
towards free software (democratic software ~period~). mr stallman, please 
think of open source as a step towards what it is you are working for. the 
world will not change in a few short years. but, it does change, and change 
it has towards free software.

two separate arguments to show the counter productiveness of this whole 
thread (open source against free software):

in regards to the whole cam issue allowing modules to be used bypassing the 
include of the headers, it was mentioned that firmware is not software, and 
hence, is not subject to the gpl as such. i could argue against this point 
and win in court. it is quite simple. software and firmware are both 
generated via instructions that are compiled into a machine readable form. 
the only difference is that at runtime, the storage mechanisms are 
different. today, i inserted a floppy disk into a computer and updated the 
firmware on the system board. during the time that firmware was on the 
floppy, was it not a binary object no different than any other program? 
shouldnt it be conceived that all binaries within in a computer are equal 
under the vision of the law, regardless of storage type? or does a 
particular storage format encapsulate the contents to make them 
unsusceptible to certain types of law, and hence could be deemed as 
inadmissible in court. if such is the case, then who determines the 
containers that are admissible? what characteristics make a container 
exempt? could i program an eprom with the linux kernel + gnu system and 
close source it since it is in firmware? the question is quite ridiculous. 
a container would never make something contained within it exempt from law. 
hence, it is obviously legal for mr torvalds, mr stallman, and all the 
other copyright holders of linux and gnu to sue someone that uses it in a 
chip and does not make available the sources.

at the same time that the cam argument for closed sources can be shot down, 
it can be shown that the kernel can be opened up to allow closed source 
binaries to coexist with the gpl. a kernel patch, call it `sys_binary' can 
be created that is released under the gpl. it exports a very simple api 
with one function taking one parameter: kernel_request(struct_req *req), 
such that closed source binaries used as modules call upon it. based upon 
the values within the struct_req struct, the sys_binary patch (module?) 
calls one of the kernel sys functions passing it parameters retrieved from 
other members of the struct. the header file for this module is then 
released to _public_ _domain_. even if the patch is not included in the 
main kernel, hence not distributed with the kernel sources, the patch could 
be maintained somewhere accessible to the public with a version for each 
kernel. the closed source binary that calls upon kernel_request() could not 
be shown as a derivative of the kernel as _all_ programs request kernel 
functions, and this function is vague and general. furthermore, since the 
header file for sys_binary is released as public domain by its author, the 
header file can be used without discretion.

now, where have we gotten with all of this argument? what is accomplished 
is nothing. the drive towards a free software society does not gain from 
arguments within the community itself, even if the sides involved could be 
segregated into `cousins'. free software _needs_ the open source movement 
to allow society as a whole to come to terms with what free software stands 
for, and the benefits it can create. in years to come, perhaps truly free 
software will result from all of the efforts made by everyone working under 
the umbrella of `free software' today.

with the high level of energy i have seen coming from people about all of 
this, just imagine what could be accomplished if you teamed up and started 
working towards a truly free world of software? imagine not being able to 
access any software on your computer because a law was passed declaring the 
`hard drive' as a cam device. again, i ask you to please think about it... 
there are people with very large incentives trying to break apart this 
community.


billy rose


