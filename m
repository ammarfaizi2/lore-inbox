Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVAXMop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVAXMop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVAXMop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:44:45 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:27591 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261291AbVAXMoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:44:44 -0500
Date: Mon, 24 Jan 2005 12:43:26 +0000
From: Ian Norton <bredroll@darkspace.org.uk>
To: linux-kernel@vger.kernel.org
Subject: zlib or crypto ?
Message-ID: <20050124124326.GA25406@earth.dsh.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to write a module that uses deflate, I'm wondering which is the best
point to use the zlib functions from, crypto.h or zlib.h

i only need to compress data of about 4k in size, 

any suggesions?

Regards

Ian

-- 
/* www.darkspace.org.uk {
 web development, application development, consultancy, firewalls 
 */
