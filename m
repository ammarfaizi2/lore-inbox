Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUCYUGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUCYUGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:06:38 -0500
Received: from RJ127212.user.veloxzone.com.br ([200.141.127.212]:36291 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S263595AbUCYUFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:05:39 -0500
Date: Thu, 25 Mar 2004 17:04:30 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre6
Message-ID: <Pine.LNX.4.58.0403251704100.6028@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Marcelo Tosatti wrote:

> Here goes the last -pre of 2.4.26 series.

Also, why are CONFIG_IPV6_SCTP__ and CONFIG_SCTP_HMAC_SHA1 set
to y if I have CONFIG_IPV6 and CONFIG_IP_SCTP disabled ?

CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_SCTP_HMAC_NONE is not set
CONFIG_SCTP_HMAC_SHA1=y
# CONFIG_SCTP_HMAC_MD5 is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

-- 
http://www.pervalidus.net/contact.html
