Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280953AbRKCNQ6>; Sat, 3 Nov 2001 08:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKCNQr>; Sat, 3 Nov 2001 08:16:47 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:53773 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S280953AbRKCNQc>; Sat, 3 Nov 2001 08:16:32 -0500
Date: Sat, 3 Nov 2001 14:16:28 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Gniazdowski <refuse7@poczta.fm>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DPMS from vconsole?
Message-ID: <20011103141628.E22427@arthur.ubicom.tudelft.nl>
In-Reply-To: <20011103115526.4464B1C2FC@pa160.grajewo.sdi.tpnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011103115526.4464B1C2FC@pa160.grajewo.sdi.tpnet.pl>; from refuse7@poczta.fm on Sat, Nov 03, 2001 at 12:55:25PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 12:55:25PM +0100, Gniazdowski wrote:
> Can be monitor turned off from vconsole (not from X) using DPMS techniques?

setterm -blank 3 -powerdown 6 -powersave on


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
