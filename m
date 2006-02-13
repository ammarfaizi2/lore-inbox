Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWBMRMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWBMRMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWBMRMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:12:37 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:10780 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932258AbWBMRMg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:12:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zy7hWFHrTTnW3uiXrNHFlUZo/cKH6viox3bj2rD2UhvZID2JKkmi6vVcWgLntHqv0SinQT8lvM8n9Zqn4TbAOyKz0DX7aUgHPDmF30S35Hp/OTyELboyEDemSLlNZ+sg698KPHh47eXZHIvv9BeVNWzhN7XKm7ovL7JuomCDgyI=
Message-ID: <d120d5000602130912n6bae7f81p41be075fe5804e51@mail.gmail.com>
Date: Mon, 13 Feb 2006 12:12:33 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] Add logitech mouse type 99
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <Pine.SOC.4.61.0602051459260.17326@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.SOC.4.61.0602051459260.17326@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/06, Meelis Roos <mroos@linux.ee> wrote:
> Add Logitech mouse type 99 (Premium Optical Wheel Mouse, model M-BT58,
> plain 3 buttons + wheel) to cure the following message:
> logips2pp: Detected unknown logitech mouse model 99
>
> Signed-off-by: Meelis Roos <mroos@linux.ee>

Applied to my tree, thank you Meelis.

--
Dmitry
