Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268025AbRGZPhp>; Thu, 26 Jul 2001 11:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267685AbRGZPhf>; Thu, 26 Jul 2001 11:37:35 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:60633 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S268063AbRGZPhX>; Thu, 26 Jul 2001 11:37:23 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE1008EAA8@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: linux-kernel@vger.kernel.org
Subject: Validating Pointers
Date: Thu, 26 Jul 2001 08:36:49 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Is there a general (correct) kernel subroutine to validate a pointer
received in a routine as input from the outside world?  Is access_ok() a
good one to use?

Andy


