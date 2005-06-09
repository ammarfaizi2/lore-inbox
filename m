Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVFIAgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVFIAgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVFIAez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:34:55 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:52589 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262224AbVFIAei convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:34:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gcptyTnILtGJqHW1tLNxrQzLyebiOxqtFyquKJaNVAESxsRCO2zrFxmDzKtZTcoeiI/armkZ7KjO8HsNBhupMh4cgqa47OGDkULLACj7hsy19rMNpMTMIUwuEK839eRrL53ZDAPcZLKxx1LQ5G9ueU2+V4XV5R2zNKT5CeBvoZ4=
Message-ID: <9e47339105060817342bdd2dd@mail.gmail.com>
Date: Wed, 8 Jun 2005 20:34:34 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Dell BIOS and HPET timer support
Cc: lkml <linux-kernel@vger.kernel.org>, Bob Picco <Robert.Picco@hp.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004EBD1B0@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88056F38E9E48644A0F562A38C64FB6004EBD1B0@scsmsx403.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> But, this will not affect normal kernel functioning. This will only
> affect is someone wants to use /dev/hpet interface.

I tried the little demo program in Documentation/hpet.txt It seems to work fine.

Still not sure what 0ns tick signifies. This is an Intel ICH5 chipset.

-- 
Jon Smirl
jonsmirl@gmail.com
