Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132876AbRDEMbS>; Thu, 5 Apr 2001 08:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132877AbRDEMbI>; Thu, 5 Apr 2001 08:31:08 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:33988 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S132876AbRDEMa5>; Thu, 5 Apr 2001 08:30:57 -0400
Message-ID: <3ACC6425.CBF6BCC4@oracle.com>
Date: Thu, 05 Apr 2001 14:25:09 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac3 XIRCOM_CB only working as module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the new xircom_cb driver only works as module - if built
 in kernel there is no sign of eth0 setup.

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19/2.4.3-ac3 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.4
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
