Return-Path: <linux-kernel-owner+w=401wt.eu-S932755AbXARW4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbXARW4N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbXARW4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:56:12 -0500
Received: from main.gmane.org ([80.91.229.2]:59106 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbXARW4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:56:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: EDAC chipkill messages
Date: Thu, 18 Jan 2007 15:55:33 -0700
Message-ID: <eoott5$86n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please explain to me what these mean?

EDAC k8 MC1: general bus error: participating processor(local node 
origin), time-out(no timeout) memory transaction type(generic read), mem 
or i/o(mem access), cache level(generic)
EDAC MC1: CE page 0xfbf6f, offset 0x4d0, grain 8, syndrome 0xc8f4, row 
1, channel 0, label "": k8_edac
EDAC MC1: CE - no information available: k8_edac Error Overflow set
EDAC k8 MC1: extended error code: ECC chipkill x4 error

Thanks!

-- 
Orion Poplawski
Technical Manager                     303-415-9701 x222
NWRA/CoRA Division                    FAX: 303-415-9702
3380 Mitchell Lane                  orion@cora.nwra.com
Boulder, CO 80301              http://www.cora.nwra.com

