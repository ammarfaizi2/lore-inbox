Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTEEQV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTEEQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:21:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65187 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263619AbTEEQUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:20:52 -0400
Date: Mon, 05 May 2003 09:32:43 -0700
From: "Martin J. Bligh" <mjbligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 650] New: driver model needs easy way to create subdirs 
Message-ID: <9870000.1052152363@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=650

           Summary: driver model needs easy way to create subdirs
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: greg@kroah.com


There needs to be a simple way to create subdirectories in the driver model
for the sysfs trees, without having to dive down to raw kobjects.

