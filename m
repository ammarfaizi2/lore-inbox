Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288339AbSANIMZ>; Mon, 14 Jan 2002 03:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSANIMP>; Mon, 14 Jan 2002 03:12:15 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:12560 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S288339AbSANIMH> convert rfc822-to-8bit; Mon, 14 Jan 2002 03:12:07 -0500
X-Envelope-From: martin.macok@underground.cz
Date: Mon, 14 Jan 2002 09:12:06 +0100
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: low latency versus sched O(1) - and versus preempt
Message-ID: <20020114091206.A1333@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020111131252.A1366@sarah.kolej.mff.cuni.cz> <20020114010134.D1399@sarah.kolej.mff.cuni.cz> <20020114090644.A1332@sarah.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114090644.A1332@sarah.kolej.mff.cuni.cz>; from martin.macok@underground.cz on Mon, Jan 14, 2002 at 09:06:44AM +0100
X-Echelon: GRU NSA GCHQ CIA Pentagon nuclear conspiration war teror anthrax
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 09:06:44AM +0100, Martin Maèok wrote:
> However, comparing full_ll versus O(1)+mini_ll when there's no
> load, I get 10% higher framerate of XMMS/Jess audio/visual plugin.

(forgot to finish the sentence...) higher framerate with full_ll.

but:

> When there is some real load, O(1)+mini_ll performs ~30% higher
> framerate then just full_ll.

-- 
         Martin Maèok                 http://underground.cz/
   martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
