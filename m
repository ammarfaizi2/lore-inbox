Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWF2GWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWF2GWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 02:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWF2GWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 02:22:54 -0400
Received: from [220.227.188.61] ([220.227.188.61]:9156 "EHLO
	gateway.innomedia.soft.net") by vger.kernel.org with ESMTP
	id S932586AbWF2GWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 02:22:53 -0400
Message-ID: <44A371EA.6080900@innomedia.soft.net>
Date: Thu, 29 Jun 2006 11:53:38 +0530
From: Dipti Ranjan Tarai <dipti@innomedia.soft.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pdflush consume 100% of cpu utilization.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
        I am using Fedora Core-3 with kernel 2.6.10 to develop a 
loadable module. when I am trying a huge amount of I/O,  pdflush daemon 
consume 100% of cpu utilization.  Due to this it reduce the module 
performance. So please give any suggestion how to tune pdflush daemon  
or is there any patch required for this.

Regards
Dipti Ranjan Tarai
