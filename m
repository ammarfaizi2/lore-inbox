Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTDIUAo (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTDIUAo (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:00:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4510
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263758AbTDIUAn (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 16:00:43 -0400
Subject: Re: 2.5.67-ac1 IDE trouble
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030409195829.GA4586@brodo.de>
References: <20030409195829.GA4586@brodo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049915644.10869.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 20:14:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 20:58, Dominik Brodowski wrote:
> Hi Alan,
> 
> In recent 2.5. kernels I see a few messages like this during heavy I/O load:

Its an IRQ handling bug but not yet one I fully understand

