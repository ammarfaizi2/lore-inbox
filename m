Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTIARja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTIARja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:39:30 -0400
Received: from smtp.slac.stanford.edu ([134.79.18.80]:55941 "EHLO
	smtp.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S263172AbTIARj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:39:29 -0400
Date: Mon, 01 Sep 2003 10:39:27 -0700
From: Philip Clark <pclark@SLAC.Stanford.EDU>
Subject: orinoco wireless driver
To: linux-kernel@vger.kernel.org
Message-id: <x34vfscwgq8.fsf@bbrcu5.slac.stanford.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone, 

My wireless card is not working in the new test4 kernel. It appears the
driver is broken and the card gets detected as a memory card and the
kernel module memory_cs tries to get loaded instead. Does anyone know
if there is a fix for this?

-Phil

-- 
Philip J. Clark                    MS34 (Colorado) 
tel 1-650-926-4203                 SLAC, PO Box 20450
fax 1-650-926-3882                 Stanford, CA 94309
pclark@slac.stanford.edu           USA 
