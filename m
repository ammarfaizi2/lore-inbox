Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbTHUT1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 15:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTHUT1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 15:27:04 -0400
Received: from 115.114.254.64.virtela.com ([64.254.114.115]:22191 "EHLO
	megisto-e2k.megisto.com") by vger.kernel.org with ESMTP
	id S262870AbTHUT1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 15:27:03 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Private header in skbuff
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Thu, 21 Aug 2003 15:27:02 -0400
Message-ID: <AD3C7008DB448D42ABA9346FE715E8340FFEFA@megisto-e2k.megisto.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Private header in skbuff
Thread-Index: AcNoGjKdINtsTeg3R/2s/CIp21Gnug==
From: "Pankaj Garg" <PGarg@MEGISTO.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two kernel modules, one below and other above the Linux IP Stack.
With every packet I need to send some extra information from lower
module to upper module. How can I achieve it? Is there a way of adding a
private header to existing skbuff structure?

Regards,
Pankaj

