Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293094AbSCEMsw>; Tue, 5 Mar 2002 07:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293082AbSCEMsn>; Tue, 5 Mar 2002 07:48:43 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:27080 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S293094AbSCEMsX>; Tue, 5 Mar 2002 07:48:23 -0500
Date: Tue, 5 Mar 2002 13:48:20 +0100 (MET)
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-X-Sender: sithglan@faui02.informatik.uni-erlangen.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: SOLVED Re: 2.4.18: Problems with IP: kernel level autoconfiguration
In-Reply-To: <Pine.GSO.4.44.0203051338470.6405-100000@faui02.informatik.uni-erlangen.de>
Message-ID: <Pine.GSO.4.44.0203051347520.6405-100000@faui02.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to specify the right kernel command line ;(

On Tue, 5 Mar 2002, Thomas Glanzmann wrote:

> My 2.4.18 Kernel does not try to receive dhcp.
>
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> CONFIG_IP_PNP_RARP=y
>
> Is there anything else out here which I have to enable in order to get things
> work? Is there any further Documentation in the tree?
>
> Greetings,
>
> 		Thomas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

