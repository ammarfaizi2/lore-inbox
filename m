Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWHOQJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWHOQJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbWHOQJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:09:36 -0400
Received: from smtp19.orange.fr ([80.12.242.1]:51077 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S965381AbWHOQJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:09:36 -0400
X-ME-UUID: 20060815160934344.540771C00087@mwinf1904.orange.fr
Message-ID: <44E1F1BA.6020903@wanadoo.fr>
Date: Tue, 15 Aug 2006 18:09:30 +0200
From: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pb installation with .deb
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !
I would like install my compiled kernel but I done an error and 
installed two kernel with the same name. Now, I can't uninstall one of 
them. I have a Sementation error, and the console says that it's 
considered that noone file of the package is installed actually.
When I want reinstall (dpkg -i) uninstall (dpkg -r) the broken package 
(kernel-image-2.6.17.081006), dpkg suggest to do a dpkg --configure -a 
to solve the problem, but it's long and not certified, isn't it ?

Thanks very much,
Thibaud.
