Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSBDAZQ>; Sun, 3 Feb 2002 19:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287946AbSBDAZI>; Sun, 3 Feb 2002 19:25:08 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:39177 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S287933AbSBDAYx>;
	Sun, 3 Feb 2002 19:24:53 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Sun, 3 Feb 2002 16:24:44 -0800
To: Alexander Sandler <ASandler@store-age.com>
Cc: "Linux Kernel Mailing List \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17: Bug?
Message-ID: <20020203162444.A28314@vato.org>
In-Reply-To: <BDE817654148D51189AC00306E063AAE054619@exchange.store-age.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BDE817654148D51189AC00306E063AAE054619@exchange.store-age.com>; from ASandler@store-age.com on Sun, Feb 03, 2002 at 06:04:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds like you're using the qlogic 4.27beta or 4.36beta from the qlogic
website.  The 4.46.12beta has a shorter time out.  In any of them you can
control this...Look at qla2x00.h.

t.

-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
