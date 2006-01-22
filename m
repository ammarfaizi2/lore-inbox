Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWAVLut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWAVLut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 06:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWAVLut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 06:50:49 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:10044 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932413AbWAVLus convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 06:50:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PRNldQDwK7AGJk604CRTkzzklrdm8zDJEvFokYW1QAVoL5Cnj+nQ3UkcDjZrCZ9ZeT+r2ZuhUKwNR6DMTuStCXoOd4lCr0Z7MHkxYjVbRFWDp3hhfMTEvXtfTms2+1pRKaR4wrOf5t9TyPP2UJkNIOC9JC4MolWFqSri1JZA+dc=
From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Guillemot joystick not working since 2.6.14
Date: Sun, 22 Jan 2006 12:50:26 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601221250.26792.marek.vasut@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found a problem with guillemot "force feedback joystick". It´s not working 
since 2.6.13.2-mm3. 2.6.14.2 wasn´t working too. 2.6.15-mm2 is the same. When 
I plug it in, it prints "configuration #1 chosen from 1 choice" "registered 
new driver iforce" and >"iforce: probe of 4-2:1.0 failed with error -12"<
It was working well on 2.6.13.1, but now it doesnt. I am not able to debug the 
kernel. Could you please fix this or tell me what am I doing wrong? Thanks.

Marex
