Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbULTX5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbULTX5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULTXy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:54:59 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:57506 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261683AbULTXxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:53:32 -0500
From: Andrew Walrond <andrew@walrond.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: USB storage (pendrive) problems
Date: Mon, 20 Dec 2004 23:52:38 +0000
User-Agent: KMail/1.7.2
Cc: Attila BODY <compi@freemail.hu>, linux-kernel@vger.kernel.org
References: <1103579679.23963.14.camel@localhost> <200412202325.20064.andrew@walrond.org> <41C75E8B.1020200@osdl.org>
In-Reply-To: <41C75E8B.1020200@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412202352.38277.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 December 2004 23:21, Randy.Dunlap wrote:
>
> and which usb driver are you using?
> ub or usb-storage?  (what's the /dev name that you mount?)

My pen gets mounted as /dev/sdc1 on the usb1 x86_64 box which I mostly use , 
and /dev/uba1 on a usb2 P4 box. The pen seems to work fine on both.

Andrew
