Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbTATRwF>; Mon, 20 Jan 2003 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbTATRwF>; Mon, 20 Jan 2003 12:52:05 -0500
Received: from beta.bandnet.com.br ([200.195.133.131]:55818 "EHLO
	beta.bandnet.com.br") by vger.kernel.org with ESMTP
	id <S266354AbTATRwF>; Mon, 20 Jan 2003 12:52:05 -0500
From: "User &" <breno_silva@beta.bandnet.com.br>
To: linux-kernel@vger.kernel.org
Subject: Process Migration
Date: Mon, 20 Jan 2003 15:03:54 -0300
Message-Id: <20030120180354.M45518@beta.bandnet.com.br>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 200.195.248.105 (breno_silva)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I´d like to do some source to do Process Migration with two linux , with 
socket.
But i am not sure if i can construct another task struct on Linux A , with 
information of Linux B and send this with socket for Linux A . So , with this 
i would like to continue run the process (of linux B) on Linux A.
Please , somebody , i´d like to know if this is possible , and what the 
informations i need send with socket to construct the same process , and 
continue to run on another machine.

Breno
----------------------
WebMail Bandnet.com.br

