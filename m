Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319191AbSIDPsS>; Wed, 4 Sep 2002 11:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319194AbSIDPqd>; Wed, 4 Sep 2002 11:46:33 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:31758 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319191AbSIDPq3>;
	Wed, 4 Sep 2002 11:46:29 -0400
Date: Wed, 4 Sep 2002 08:49:08 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] pci_free_consistent on ohci initialisation failure
Message-ID: <20020904154908.GD6198@kroah.com>
References: <Pine.LNX.4.44.0209011608550.26729-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209011608550.26729-100000@linux-box.realnet.co.sz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 04:10:37PM +0200, Zwane Mwaikambo wrote:
> The trace at the end of the message shows the init failure.

Thanks, applied.

greg k-h
