Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVKOPoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVKOPoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVKOPoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:44:20 -0500
Received: from web34704.mail.mud.yahoo.com ([209.191.68.153]:36179 "HELO
	web34704.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932547AbVKOPoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:44:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WOI3ISmh/kXmbgKQ6vxY1f5C+f6SHPxg8IzTR1D9mKbf7hx/txkTrB1xPFznMmMNZfhrHm/e/H7/wET0/cRaF/v94LSHTzxrueRo/aA+wx2pC3duedjWVdlZ3WLWvk6rg13l7lSfHFXfcPEY7nlDNcbllZiVUCZiX8JpmaSNv8E=  ;
Message-ID: <20051115154419.32707.qmail@web34704.mail.mud.yahoo.com>
Date: Tue, 15 Nov 2005 23:44:19 +0800 (CST)
From: Stephen Liu <satimis@yahoo.com>
Subject: Failed to load modules : loop
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Linux-2.6.11.12

On mounting;

# mount -o loop xxx.sqfs /mnt/point
OR
# mount -t squashfs -o loop xxx.sqfs /mnt/point

it prompted;
Failed to load modules : loop

However loop has been enbled as module.

Please advise where shall I check. TIA

BR
Stephen Liu
