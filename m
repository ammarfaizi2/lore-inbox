Return-Path: <linux-kernel-owner+w=401wt.eu-S932186AbXABJjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXABJjU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 04:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbXABJjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 04:39:20 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:46049 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbXABJjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 04:39:19 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: question on writing in serial drivers
Date: Tue, 2 Jan 2007 10:39:21 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021039.21825.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

am I correct thinking that tty_operations::write() must not sleep?

	Regards
		Oliver
