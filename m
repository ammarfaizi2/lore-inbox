Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272877AbTG3NGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272878AbTG3NGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:06:07 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:59143 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S272877AbTG3NGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:06:06 -0400
Date: Wed, 30 Jul 2003 07:06:05 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, ak@suse.de,
       alan@lxorguk.ukuu.org.uk, James.Bottomley@SteelEye.com, axboe@suse.de,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030730130605.GA13333@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com> <20030723114006.GA28688@dsl2.external.hp.com> <20030728131513.5d4b1bd3.ak@suse.de> <20030730044256.GA1974@dsl2.external.hp.com> <20030729215118.13a5ac18.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729215118.13a5ac18.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 09:51:18PM -0700, David S. Miller wrote:
> Make an ext2 filesystem with 16K blocks :-)

heh - right. I thought you were going to tell me I needed to
install DIMMs that support 4k pages :^)

grant
