Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbTJPIsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTJPIsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:48:07 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:6069 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262759AbTJPIsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:48:04 -0400
Message-ID: <20031016084759.13936.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "drn ayngl" <dzt@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2003 16:47:59 +0800
Subject: concentration of string literals with _FUNCTION_ is depreciated
X-Originating-Ip: 65.30.202.235
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using gcc while compiling  for modules i am getting   
 
errors such as; 
 
concentration of string literals with _FUNCTION_ is depreciated 
 
setup_string is defined but no used 
 
warning : implicit declaration of ... 
 
warning : duplicate const... 
 
what are these messages related to? 
what might be causing them? 
 
thanks 
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
