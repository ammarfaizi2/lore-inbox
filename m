Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVEPO6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVEPO6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVEPO6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:58:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4015 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261670AbVEPO4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:56:13 -0400
Date: Mon, 16 May 2005 15:56:07 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
Subject: Re: [PATCH 2.6.12-rc4-mm1 1/4] megaraid_sas: updating the driver
Message-ID: <20050516145607.GC25156@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
	Andrew Morton <akpm@osdl.org>,
	'James Bottomley' <James.Bottomley@SteelEye.com>,
	"Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE7A@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCE7A@exa-atlanta>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 02:51:22AM -0400, Bagalkote, Sreenivas wrote:
> Hello All,
> 
> Please review this update to the previously submitted megaraid_sas driver.
> I have adopted all the feedback received for the initial submission. Since
> most of the code is rearranged, I have split the patches into four parts - 
> the first two remove the original code and the second two add the new code.

As your driver is not in the scsi tree yet please send diff in future that
just apply against the scsi-misc tree.  Also please use a mailer that
doesn't mangle the patches.

