Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUBPLMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 06:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUBPLMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 06:12:33 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:9130 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265111AbUBPLMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 06:12:32 -0500
Message-ID: <4030A561.8070701@t-online.de>
Date: Mon, 16 Feb 2004 12:11:29 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <1o903-5d8-7@gated-at.bofh.it> <1pkw6-3BU-3@gated-at.bofh.it> <1prnS-4x8-1@gated-at.bofh.it> <402F8A00.8030501@uchicago.edu> <40306F65.8060702@t-online.de> <yw1xy8r3e7gb.fsf@ford.guide>
In-Reply-To: <yw1xy8r3e7gb.fsf@ford.guide>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Seen: false
X-ID: VsAJ3gZCYej9MmyNignHBgItD2vQyUT02xngFi+++nq2a23SLHJoYv
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Harald Dunkel <harald.dunkel@t-online.de> writes:
> 
> 
> /proc/modules uses only _ so you could use ${module_name/-/_}.
> 

Please check the archive: My original complaint was about the
inconsistency between /proc/modules listing all modules with '_',
and the module filenames using both '-' and '_'. For me it is
not important which version is better. As a developer I have to
assume that '_' and '-' are ambiguous in this context. This
ambiguity is pretty strange for Unix, isn't it?


Regards

Harri
