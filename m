Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUBLTbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266563AbUBLT27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:28:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266560AbUBLT2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:28:55 -0500
Message-ID: <402BD3E8.5040808@pobox.com>
Date: Thu, 12 Feb 2004 14:28:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bas Mevissen <ml@basmevissen.nl>
CC: Jamie Lokier <jamie@shareable.org>, Kyle <kyle@southa.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ICH5 with 2.6.1 very slow
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl> <001101c3ecf8$b0f50cc0$b8560a3d@kyle> <40274581.4030002@basmevissen.nl> <004501c3f0ae$ecdd2ec0$b8560a3d@kyle> <20040212084110.GB20898@mail.shareable.org> <402B8E8E.1010607@basmevissen.nl>
In-Reply-To: <402B8E8E.1010607@basmevissen.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another idea...  check and make sure your hardware is set to "enhanced 
mode" in BIOS.  "legacy mode" and "combined mode" would definitely be slow.

	Jeff




