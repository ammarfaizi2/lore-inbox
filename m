Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUGGRuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUGGRuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUGGRuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:50:11 -0400
Received: from monster.roma2.infn.it ([141.108.255.100]:481 "EHLO
	monster.roma2.infn.it") by vger.kernel.org with ESMTP
	id S265255AbUGGRuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:50:07 -0400
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: Re: difference between ports
Date: Wed, 7 Jul 2004 19:50:00 +0200
User-Agent: KMail/1.6.2
References: <20040707171452.9714.qmail@web53201.mail.yahoo.com>
In-Reply-To: <20040707171452.9714.qmail@web53201.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407071950.00690.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:14, mercoledì 7 luglio 2004, you wrote:
> I would like to know if there are any difference
> between I/O ports such as serial port, parallel port,
> keyboard and ide from those ones used by network
> interface, such as ssh, ftp, http and telnet. Both can
> be accessed by check_region(), request_region() and
> release_region() functions? If not, what functions can
> be used to access those ports in kernel mode?


ehmm .. you are a bit confused I guess ..
you are confusing at least 3 different meanings of the term "port"...
kernel functions you cite refer to the I/O ports (different from serials, 
parallels and keyborad)

-- 
<?php echo '       Emiliano `AlberT` Gabrielli       '."\n".
           '  E-Mail: AlberT_AT_SuperAlberT_it  '."\n".
           '  Web:    http://SuperAlberT.it  '."\n".
'  IRC:    #php,#AES azzurra.com '."\n".'ICQ: 158591185'; ?>
