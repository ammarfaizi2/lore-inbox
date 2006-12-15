Return-Path: <linux-kernel-owner+w=401wt.eu-S1752186AbWLOOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbWLOOM1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbWLOOM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:12:27 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:51942 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbWLOOM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:12:26 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: interface for modems with out of band signalling
Date: Fri, 15 Dec 2006 15:14:00 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612151514.00390.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have got a question about modems which use the AT command set, but
don't use in band signalling like true rs232 modems. Would two device nodes
per communication channel be a good interface?

	Regards
		Oliver
