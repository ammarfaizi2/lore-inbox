Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTFXRrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTFXRrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:47:43 -0400
Received: from [62.29.72.175] ([62.29.72.175]:16256 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S262737AbTFXRrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:47:42 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: linux-kernel@vger.kernel.org
Subject: Weird modem behaviour in 2.5.73-mm1
Date: Tue, 24 Jun 2003 21:02:49 +0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
Message-Id: <200306242102.49356.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

First I did not tried 2.5.73 vanilla so this can be a bug in 2.5.73 itself . 
When I use my 56k modem to connect to internet it always hang up 5-6 minutes 
( sometimes like 1-2 minutes ) later. I checked with 2.5.72-mm1 and I got not 
hang-up whatsoever. I checked system logs and it just says :

[pppd] Modem Hang Up

Anyone noticed this behaviour?


Regards,
/ismail
