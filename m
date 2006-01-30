Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWA3FL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWA3FL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWA3FL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:11:26 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:59698 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750758AbWA3FLZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:11:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BXk0Q2dRsqt7+o+7ALGpdhekcybS4oeRJD20nv0xT/2IPFSiij+LgInzL5/RHMCCsjmajF8Vusy5gRFxOCazYrDKiKGDvBc8vUuJh6gf58os0v09NDzBCfnBFpWVuO1xuPvrR/gXOD/SShVnPk/qcVT/+5P0kcSzybhReiD/9NU=
Message-ID: <aed62bae0601292111s38714b3bsd2c58abc83188aea@mail.gmail.com>
Date: Mon, 30 Jan 2006 10:41:24 +0530
From: sarat <saratkumar.koduri@gmail.com>
To: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: insmod error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1e62d1370601292104s3e8ad2bcx2d67e626cac04c8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aed62bae0601292023l641fb644k870a2b1b099e6dc3@mail.gmail.com>
	 <1e62d1370601292104s3e8ad2bcx2d67e626cac04c8a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is the error given in 'dmesg' hope this is okay..
firewall: module license 'unspecified' taints kernel.
firewall: Unknown symbol register_firewall
firewall: Unknown symbol unregister_firewall

On 1/30/06, Fawad Lateef <fawadlateef@gmail.com> wrote:
> On 1/30/06, sarat <saratkumar.koduri@gmail.com> wrote:
> > insmod: error inserting 'firewall.ko': -1 Unknown symbol in module
> > plz tell me how to solve this..
> >
>
> Give the details of the unknown symbols in module error. This can be
> get through log (run command dmesg, and see in the last about the
> unresolved symbols) !
>
> This error comes mostly due to missing header files in your module
>
>
> --
> Fawad Lateef
>


--
ur's sarat
