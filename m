Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTDOMdU (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTDOMdU 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:33:20 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1152 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261338AbTDOMdT (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:33:19 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304151247.h3FClnq2000157@81-2-122-30.bradfords.org.uk>
Subject: Re: module for sony network walkman
To: b_adlakha@softhome.net (Balram Adlakha)
Date: Tue, 15 Apr 2003 13:47:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200304151650.06394.b_adlakha@softhome.net> from "Balram Adlakha" at Apr 15, 2003 04:50:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any driver available for accessing the flash memory of my sony usb 
> network walkman (nw-e5)? This thing was quite expensive and I really would 
> like it to work.

At a guess, it might just act like a disk device.  Without a lot more
information, I can't help you any further.  What does lsusb say about
it?

John.
