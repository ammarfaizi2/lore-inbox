Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSGQOif>; Wed, 17 Jul 2002 10:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSGQOif>; Wed, 17 Jul 2002 10:38:35 -0400
Received: from 12-252-146-102.client.attbi.com ([12.252.146.102]:40713 "EHLO
	archimedes") by vger.kernel.org with ESMTP id <S315200AbSGQOif>;
	Wed, 17 Jul 2002 10:38:35 -0400
Date: Wed, 17 Jul 2002 08:42:03 -0600
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc2 and !CONFIG_BLK_DEV_IDEPCI
Message-ID: <20020717144203.GA28159@galileo>
Mail-Followup-To: James Mayer <james@cobaltmountain.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0207171458420.16979-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207171458420.16979-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
From: James Mayer <james@cobaltmountain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've reproduced the same problem here, as well, on x86 ISA IDE.
Geert's first patch worked for me.

  James  
