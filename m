Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUHQC67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUHQC67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 22:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUHQC67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 22:58:59 -0400
Received: from av6.lga.net.sg ([203.92.64.141]:45719 "HELO av6.lga.net.sg")
	by vger.kernel.org with SMTP id S261234AbUHQC66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 22:58:58 -0400
Message-ID: <01C48448.D5B44750.vanitha@agilis.st.com.sg>
From: Vanitha Ramaswami <vanitha@agilis.st.com.sg>
Reply-To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Serial Driver for PPP - that runs in Half Duplex Mode
Date: Tue, 17 Aug 2004 10:56:22 -0000
Organization: Agilis Communications
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
Is there a serial PPP Driver , that is capable of operating in half duplex 
mode. I have a radio that operates in half duplex mode and it has a serial 
interface. I want to establish a Point to Point connection between two 
Radios.

Do you have a serial port PPP Driver that supports half-duplex mode of 
operation ?. i.e.  I need RTS to be active when you are transmitting data 
and to be inactive to receive.

Thanks
Vanitha

