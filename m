Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbTGKVvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbTGKVvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:51:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60344
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266899AbTGKVt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:49:29 -0400
Subject: Re: 2.5 'what to expect'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030711193316.GA28806@gtf.org>
References: <20030711140219.GB16433@suse.de>
	 <20030711181453.GA976@matchmail.com>  <20030711193316.GA28806@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057960893.20637.60.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 23:01:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 20:33, Jeff Garzik wrote:
> IIRC Alan's comment was "this fixes 99% of it"

I fixed the 2.4 one, but the 2.4 fix relies on old style scsi error
handling which has (thankfully on the whole) gone away in 2.5

