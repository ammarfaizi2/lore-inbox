Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbUJZGSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbUJZGSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUJZGSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:18:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:60095 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262144AbUJZGSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:18:32 -0400
Date: Tue, 26 Oct 2004 08:17:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Nico Augustijn." <kernel@janestarz.com>
cc: hvr@gnu.org, clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase
In-Reply-To: <200410251354.31226.kernel@janestarz.com>
Message-ID: <Pine.LNX.4.53.0410260816230.30255@yvahk01.tjqt.qr>
References: <200410251354.31226.kernel@janestarz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This here patch will make the kernel use a default passphrase (compiled into
>the kernel or cryptoloop.ko module) when you set up a cryptoloop device with:

Suppose I break in via ssh:
I could load the module (if applicable), and find the address of the function
or variable in System.map, extract the static passphrase, and well. Then?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
