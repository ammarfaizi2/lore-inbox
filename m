Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbTGHE6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 00:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbTGHE6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 00:58:12 -0400
Received: from softers.net ([213.139.168.106]:26783 "EHLO mail.softers.net")
	by vger.kernel.org with ESMTP id S266531AbTGHE6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 00:58:12 -0400
Message-ID: <3F0A52F0.5BA389F9@softers.net>
Date: Tue, 08 Jul 2003 08:13:20 +0300
From: Jarmo =?iso-8859-2?Q?J=E4rvenp=E4=E4?= 
	<Jarmo.Jarvenpaa@softers.net>
Organization: Softers Oy
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Max binds
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm building chrooted environment for users and I'm using mount --bind
<what> <where> -scheme to mount some important directories for the user.
This works fine for couple users but what is the limit for binding
directories to show up on a different place? I tried googling but
couldn't find any direct answers.


Thanks,
Jarmo
