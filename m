Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275979AbRI1JJe>; Fri, 28 Sep 2001 05:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275985AbRI1JJY>; Fri, 28 Sep 2001 05:09:24 -0400
Received: from jcb.yi.org ([80.65.224.59]:57988 "HELO jcb.yi.org")
	by vger.kernel.org with SMTP id <S275979AbRI1JJR>;
	Fri, 28 Sep 2001 05:09:17 -0400
Date: Fri, 28 Sep 2001 11:09:23 +0200
From: jc <jcb@jcb.yi.org>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken in 2.4.10
Message-ID: <20010928110923.A12889@athena>
Mail-Followup-To: jc <jcb@jcb.yi.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81B0@earth.infowave.com> <E15mltQ-0005fF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15mltQ-0005fF-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On vendredi 28 septembre, 2001 à 01:52:40 +0100, Alan Cox wrote:
> Don't build later 2.4.x with egcs-1.1.2. At least some of the network
> drivers stop working mysteriously with < gcc 2.95.3, RH 2.96-74+ or 
> gcc 3.0
> 
> Its not the cause of the APM problem but be aware of it


how could i get the list of files that changed between 2.4.9 and 2.4.10
concerning apm ?
