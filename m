Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264208AbUFBVZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUFBVZF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUFBVZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:25:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22201 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264208AbUFBVYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:24:46 -0400
Message-ID: <40BE458D.4050408@pobox.com>
Date: Wed, 02 Jun 2004 17:24:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Submission of via "velocity(tm)" series adapter driver
References: <20040602201315.GA10339@devserv.devel.redhat.com> <40BE3F00.4090408@pobox.com> <20040602211646.GA9419@devserv.devel.redhat.com>
In-Reply-To: <20040602211646.GA9419@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Most of our drivers don't work bigendian. If you want it bigendian you


As an additional rebuttal, most of the PCI drivers people care about do 
work on big-endian...

	Jeff


