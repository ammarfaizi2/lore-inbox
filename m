Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUH1DMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUH1DMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 23:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUH1DMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 23:12:30 -0400
Received: from ntmail.xtreamlok.com ([203.20.243.135]:20005 "EHLO
	ntmail.xtreamlok.com") by vger.kernel.org with ESMTP
	id S266310AbUH1DM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 23:12:28 -0400
Message-ID: <412FF888.8090307@biodome.org>
Date: Sat, 28 Aug 2004 13:14:16 +1000
From: QuantumG <qg@biodome.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Milo Rogers <rogers@isi.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: reverse engineering pwcx
References: <412FD751.9070604@biodome.org> <20040828012055.GL24018@isi.edu> <20040828014931.GM24018@isi.edu>
In-Reply-To: <20040828014931.GM24018@isi.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2004 03:14:19.0066 (UTC) FILETIME=[1B6E49A0:01C48CAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Milo Rogers wrote:

>	Hmmm... a poster on Slashdot claims that entropy measurements
>imply that the pwcx code is interpolating rather that truly
>decompressing.  Again, that's integer math and table lookups.
>  
>

http://www.amazon.com/exec/obidos/tg/detail/-/B00005R098/102-7619892-0201738?v=glance

claims that the Logitech Quickcam Pro 3000 is a "True 640 x 480 
resolution video capture" which is now clearly false.

It would appear I have found an answer to my question.  The reason 
Philips made Nemosoft sign an NDA was not to hide proprietory 
information from their competitors.  It was to hide the fact that they 
were misrepresenting the resolution of their cameras to their 
customers.  No wonder Nemosoft did not feel right about opening this 
module even after the NDA expired, he would be telling the world their 
dirty little secret.  Of course I'm sure this was common knowledge to 
all those people who work in robotics and always demand an uncompressed 
stream from the camera.

Trent Waddington
Decompiler maintainer, http://boomerang.sourceforge.net/

