Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWEERTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWEERTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWEERTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:19:14 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:35166 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751181AbWEERTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:19:13 -0400
Message-ID: <445B8CC7.8050509@gentoo.org>
Date: Fri, 05 May 2006 18:35:03 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060428)
MIME-Version: 1.0
To: Shawn Starr <sstarr@platform.com>
CC: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc3][sky2] Network stalls/drops completely
References: <E2AC825D4FC7764DA86D9C8ECA27A2DE3F84FB@catoexm05.noam.corp.platform.com>
In-Reply-To: <E2AC825D4FC7764DA86D9C8ECA27A2DE3F84FB@catoexm05.noam.corp.platform.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> (plain text this time)

80-column mails would be good too :)

> We just got some new boxes and they have a sky2 nic onboard. The card
> seems ok but over time I start to get network drops. Also, If I
> restart the network I deadlocked the kernel unfortunately I don't
> have a stack dump of the crash.

You could try sky2 v1.3-rc1:

http://marc.theaimsgroup.com/?l=linux-netdev&m=114668440823339&w=2

Daniel

