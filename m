Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289199AbSANLd1>; Mon, 14 Jan 2002 06:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288696AbSANLdT>; Mon, 14 Jan 2002 06:33:19 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:9153 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S289201AbSANLdD>; Mon, 14 Jan 2002 06:33:03 -0500
Date: Mon, 14 Jan 2002 12:33:01 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: FC & MULTIPATH !? (any hope?)
Message-ID: <20020114123301.B30997@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there any hope of working combination of MULTIPATH with FC !?

At the moment I am using raid option multipath but it's one way
street, when one FC connection dies it successfully switches onto
another FC connection but when that second dies aswell, mount point
is in a limbo, no switching back to first FC connection.

Any other solutions, patches ?!

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
