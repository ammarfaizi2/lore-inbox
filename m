Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267999AbUHKI7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267999AbUHKI7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 04:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUHKI7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 04:59:31 -0400
Received: from proxy.kirov.ru ([217.9.147.44]:56844 "EHLO proxy.kirov.ru")
	by vger.kernel.org with ESMTP id S267999AbUHKI7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 04:59:30 -0400
Date: Wed, 11 Aug 2004 12:44:15 +0400
From: "Konstantin G. Khlebnikov" <c00nst@ezmail.ru>
X-Mailer: The Bat! (v1.62r)
Reply-To: "Konstantin G. Khlebnikov" <c00nst@ezmail.ru>
X-Priority: 3 (Normal)
Message-ID: <875636570.20040811124415@ezmail.ru>
To: linux-kernel@vger.kernel.org
Subject: [QUESTION] shift pages in mmap
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   how implement fast page alligned shift (cyclic rotate)
   pages in anonymous mmap ?

--
 Konstantin

