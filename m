Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUH2DG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUH2DG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 23:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUH2DG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 23:06:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267599AbUH2DG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 23:06:26 -0400
Message-ID: <41314824.1050309@pobox.com>
Date: Sat, 28 Aug 2004 23:06:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [gmulas@ca.astro.it: kernel-source-2.4.27: libata.o not compiled
 as module]
References: <20040829021638.GA29207@darjeeling.triplehelix.org> <41313FDA.6080009@pobox.com> <413144B3.4080301@triplehelix.org>
In-Reply-To: <413144B3.4080301@triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Broken config:

CONFIG_SCSI=m
[...]
CONFIG_SCSI_SATA_VITESSE=y


