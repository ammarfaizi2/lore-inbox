Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUCIU17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUCIU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:27:59 -0500
Received: from smtp.newsguy.com ([129.250.170.69]:14861 "EHLO newsguy.com")
	by vger.kernel.org with ESMTP id S262142AbUCIU15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:27:57 -0500
Message-ID: <404E36F1.8000908@newsguy.com>
Date: Tue, 09 Mar 2004 15:28:17 -0600
From: Frank Myhr <fmyhr@newsguy.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Read-only bind mounts - will they be included in 2.4.x kernel?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There was some discussion 6 months ago about including Herbert
Poetzl's Bind Mount Extensions http://www.13thfloor.at/patches/ in a
2.4.x (x = 23 at the time) kernel. Can someone please give an update?

The Bind Mount Extensions allow bind-mounting part of a rw filesystem
read-only, which is very useful to people running vservers and other
chrooted stuff.

Thanks,
Frank

