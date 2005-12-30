Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVL3Fcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVL3Fcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 00:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVL3Fcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 00:32:32 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:5104 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751045AbVL3Fcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 00:32:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mdkdUNiK8VFJxxHerBYmAIyjjhoM95TP8i5FXJ1M0oJ0DnWv5G1a2ebDGN1pv7rE65+xY0isDjWnZ3bvwqIIZA1lMRlW+TYAgBvsMWlZYV5BI6ZIglDofPaVuEhOFVZJoX21C5SJBJwDSWMAOd3JfcPech/4jaQzOpTFYdpN7Pc=
Message-ID: <f69849430512292132u58251e49s904c2d24968b9c@mail.gmail.com>
Date: Fri, 30 Dec 2005 10:32:31 +0500
From: kernel coder <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Preferred Transmit and Recieve ring buffer size and why?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am just about to do performance testing on my network card and was
wondering what is the ideal size of the transmit and the receive ring
descriptors of the DMA-capable Ethernet device. It can currently
manage 16 16-bytes transmit and receve descriptors each.

Thanks,

A J
