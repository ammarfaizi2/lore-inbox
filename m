Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTHUOoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTHUOoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:44:16 -0400
Received: from 115.114.254.64.virtela.com ([64.254.114.115]:18836 "EHLO
	megisto-e2k.megisto.com") by vger.kernel.org with ESMTP
	id S262725AbTHUOoQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:44:16 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Messaging between kernel modules and User Apps
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Thu, 21 Aug 2003 10:44:15 -0400
Message-ID: <AD3C7008DB448D42ABA9346FE715E8340FFEF8@megisto-e2k.megisto.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Messaging between kernel modules and User Apps
Thread-Index: AcNn8rGgLdjjAOVGS5+J+cB0GDCRkQ==
From: "Pankaj Garg" <PGarg@MEGISTO.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing a kernel module. The module will need to send asynchronous
messages to a User Application. Is there a good and efficient way of
doing this?


Thanks,
Pankaj


