Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVDYGLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVDYGLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 02:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVDYGLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 02:11:00 -0400
Received: from smtp6.infineon.com ([217.10.50.128]:48707 "EHLO
	smtp6.infineon.com") by vger.kernel.org with ESMTP id S262540AbVDYGKz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 02:10:55 -0400
X-SBRS: None
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: Mounting File System .
Date: Mon, 25 Apr 2005 11:39:53 +0530
Message-ID: <D99246B510C34944823191CB90759C8652804B@blrse201.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mounting File System .
Thread-Index: AcVJXDfsQ6M6pMZOTA6xMCtcWoxpVgAABhmg
From: <Mansi.Mahur@infineon.com>
To: <miklos@szeredi.hu>, <jamie@shareable.org>
Cc: <viro@parcelfarce.linux.theplanet.co.uk>, <hch@infradead.org>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 25 Apr 2005 06:10:54.0611 (UTC) FILETIME=[8A022630:01C5495D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello to All,
     I am facing problems like various warnings after giving mount point
for  jffs2 File System as  /tmp dir .
     I have Root file system as ext2 . Please can I be guided on foll :
     
      1.) Is it that Mount point for filesystem should not be /tmp .
      2.) Are there any other dir which should not be given as a mount
point for File system.
	
 BR,
 Mansi
