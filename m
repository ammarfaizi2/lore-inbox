Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVDAU0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVDAU0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVDAU0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:26:03 -0500
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:49607 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S262871AbVDAUXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:23:55 -0500
Message-ID: <424DADBD.9010509@jg555.com>
Date: Fri, 01 Apr 2005 12:23:25 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       pdh@colonel-panic.org
Subject: Re: 64bit build of tulip driver
References: <424AE9E0.8040601@jg555.com> <20050331161206.GB19219@colo.lackof.org> <424CC566.3080007@jg555.com> <20050401065120.GD29734@colo.lackof.org> <424D7AE9.5050100@jg555.com> <20050401182609.GB8178@colo.lackof.org>
In-Reply-To: <20050401182609.GB8178@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant,
    Thank you, I took your driver as a reference and added in the cobalt 
specifics to the eeprom.c file, works perfectly now.


