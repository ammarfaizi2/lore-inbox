Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273237AbRIYTkn>; Tue, 25 Sep 2001 15:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRIYTkc>; Tue, 25 Sep 2001 15:40:32 -0400
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:39622 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S273143AbRIYTkV>; Tue, 25 Sep 2001 15:40:21 -0400
Date: Tue, 25 Sep 2001 20:40:47 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 problems with X + USB mouse
Message-ID: <20010925204047.A2818@srcf.ucam.org>
In-Reply-To: <20010923222036.A1685@taral.net> <20010923233022.A30991@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010923233022.A30991@lnuxlab.ath.cx>; from khromy@lnuxlab.ath.cx on Sun, Sep 23, 2001 at 11:30:22PM -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 11:30:22PM -0400, khromy wrote:

> I had this problem too.  I used NetMousePS/2 in XF86Config but changing
> it to IMPS/2 fixed it.

Here too. Using IMPS/2 appears to have the disadvantage that the side 
buttons are only recognised as duplicates of buttons 2 and 3, whereas 
NetmousePS/2 allowed all of them to be used separately.

> 5 button Microsoft IntelliMouse?

Yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
