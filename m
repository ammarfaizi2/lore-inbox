Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTL1Vtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTL1Vtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 16:49:32 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:40410 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S262128AbTL1Vta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 16:49:30 -0500
Date: Sun, 28 Dec 2003 14:49:25 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Arnaud Fontaine <dsdebian@free.fr>
cc: Xose Vazquez Perez <xose@wanadoo.es>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.23
In-Reply-To: <20031228140039.GA1545@scrappy>
Message-ID: <Pine.LNX.4.51.0312281448050.1031@cafe.hardrock.org>
References: <3FE732A7.60402@wanadoo.es> <20031223150704.GA19243@scrappy>
 <3FE8A3D3.9090100@wanadoo.es> <20031228140039.GA1545@scrappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003, Arnaud Fontaine wrote:

> On Tue, Dec 23, 2003 at 09:21:39PM +0100, Xose Vazquez Perez wrote:
> > next steps :
> > 
> > - run burnP5 for 30 min.
> > - try 2.4.24-pre2
> 
> Hello,
> 
> So, i have compiled 2.4.24-pre2 as you say. In addition, i had this Oops
> after every reboot on 2.4.23 (nothing with 2.4.18 which works fine).
> 
> Then, I reboot again on 2.4.24-pre2 and ran `burnP5` during 40 minutes
> to be sure. I had nothing and no oops at the moment. If i see this Oops
> with 2.4.24 (nothing now ;)), i'll run burnP5 on this and i'll say you
> what i have.

Could you please try 2.4.23 with the patch at
http://www.hardrock.org/kernel/current-updates/linux-2.4.23-updates.patch

I would like to know if that helps or not.

Thanks and regards
James

> 
> Thanks for your help...
> ++ Arnaud
> 
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
