Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289114AbSCGBPo>; Wed, 6 Mar 2002 20:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSCGBPf>; Wed, 6 Mar 2002 20:15:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26512 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289114AbSCGBPS>; Wed, 6 Mar 2002 20:15:18 -0500
Message-ID: <3C86BD44.5010109@us.ibm.com>
Date: Wed, 06 Mar 2002 17:07:16 -0800
From: mingming cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <3C864F07.8050806@linkvest.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Eric Cuendet wrote:

> 
> Hi,
> I've made a new version of IO statistics in kstat that remove the
> previous limitations of MAX_MAJOR
> I've made tests on my machine.
> Could someone test it, please?
> Feedback welcome.
> Bye
> -jec

Thank for your attention and help on updating my disk io patch.  Here is 
the link to the original patch 
http://marc.theaimsgroup.com/?l=linux-kernel&m=100570447604813&w=2.  I
re-submitted it a while ago against 2.4 kernels and 2.5.2 kernel.  You
can find patches related to disk io statistics at
http://lse.sourceforge.net/resource/diskio/diskio.html

